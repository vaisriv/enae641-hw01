from pathlib import Path

import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from scipy.integrate import solve_ivp

matplotlib.use("Agg")

ROOT = Path(__file__).resolve().parents[1]
FIGURES = ROOT / "outputs/figures"
TEXT = ROOT / "outputs/text"


def heading(problem):
    print(f"\n------\n {problem}\n------")


def report(name, content):
    print(content)
    (TEXT / f"{name}.txt").write_text(content + "\n", encoding="utf-8")


def save(fig, name):
    fig.tight_layout()
    fig.savefig(FIGURES / f"{name}.png", dpi=200)
    plt.close(fig)


def main():
    FIGURES.mkdir(parents=True, exist_ok=True)
    TEXT.mkdir(parents=True, exist_ok=True)

    #########
    # p01 #
    #########
    heading("p01")
    V = np.array([[2, -2, 3], [-1, 2, 1], [4, 1, 3]])
    assert np.allclose(V @ (np.array([29, 53, -15]) / 31), [-3, 2, 4])
    print("Verified the supplied change-of-basis solution.")

    #########
    # p02 #
    #########
    heading("p02")
    g, length, mass, damping = 9.81, 2.0, 1.0, 8.0
    trim = np.pi / 3
    inertia = mass * length**2
    torque = mass * g * length * np.sin(trim)
    wn = np.sqrt(g / length * np.cos(trim))
    sigma = damping / (2 * inertia)
    zeta = sigma / wn
    wd = np.sqrt(wn**2 - sigma**2)
    t = np.linspace(0, 10, 2001)
    offset = 0.1  # illustrative small release displacement, rad
    deviation = (
        offset * np.exp(-sigma * t) * (np.cos(wd * t) + sigma / wd * np.sin(wd * t))
    )
    report(
        "s02",
        f"Trim torque = {torque:.6f} N m\n"
        f"Natural frequency = {wn:.6f} rad/s\n"
        f"Damping ratio = {zeta:.6f}\n"
        f"Damped frequency = {wd:.6f} rad/s\n"
        f"2% settling-time estimate = {4 / sigma:.6f} s",
    )
    fig, ax = plt.subplots(figsize=(6.4, 3.2))
    ax.plot(t, trim + deviation, label=r"$\theta(t)$, linearized")
    ax.axhline(trim, color="black", linestyle="--", label=r"$\theta^*=\pi/3$")
    ax.axhspan(
        trim - 0.02 * offset,
        trim + 0.02 * offset,
        alpha=0.18,
        color="gray",
        label="2% of initial displacement",
    )
    ax.set(xlabel="Time (s)", ylabel="Angle (rad)")
    ax.grid(alpha=0.25)
    ax.legend(fontsize=8)
    save(fig, "s02")

    #########
    # p03 #
    #########
    heading("p03")
    print("Reference in transformed coordinates: z* = [0, -1, t].")

    #########
    # p04 #
    #########
    heading("p04")
    print("Omega^2 < a^2: bottom asymptotically stable; top a saddle.")

    #########
    # p05 #
    #########
    heading("p05")
    print("Omega^2 > a^2: new equilibria +/- arccos(a^2/Omega^2) stable.")

    #########
    # p06 #
    #########
    heading("p06")
    a, b = 3.0, 0.25
    nominal = np.sqrt(2) * a
    k = 1.5 * a**2
    gain = np.sqrt(3) * nominal / 2
    desired_wd, desired_zeta = 2.0, 0.7
    desired_wn = desired_wd / np.sqrt(1 - desired_zeta**2)
    kp = (desired_wn**2 - k) / gain
    kd = (2 * desired_zeta * desired_wn - b) / gain
    Acl = np.array([[0.0, 1.0], [-k - gain * kp, -b - gain * kd]])
    poles = np.linalg.eigvals(Acl)
    assert np.allclose(np.abs(poles.imag), desired_wd)
    assert np.allclose(-poles.real / np.abs(poles), desired_zeta)
    report(
        "s06b",
        f"Nominal hoop rate = {nominal:.6f} rad/s\n"
        f"Input coefficient = {gain:.6f}\n"
        f"Desired natural frequency = {desired_wn:.6f} rad/s\n"
        f"Kp = {kp:.6f} s^-1\nKd = {kd:.6f}\n"
        f"Closed-loop poles = {poles[0]:.6f}, {poles[1]:.6f} s^-1",
    )
    t = np.linspace(0, 6, 1201)
    initial = [0.02, 0.01]

    def nonlinear(_, state):
        error, rate = state
        angle = trim + error
        hoop_rate = nominal - kp * error - kd * rate
        return [
            rate,
            -b * rate
            - a * a * np.sin(angle)
            + hoop_rate**2 * np.cos(angle) * np.sin(angle),
        ]

    linear = solve_ivp(
        lambda _, x: Acl @ x, [0, t[-1]], initial, t_eval=t, rtol=1e-10, atol=1e-12
    )
    nonlinear_result = solve_ivp(
        nonlinear, [0, t[-1]], initial, t_eval=t, rtol=1e-10, atol=1e-12
    )
    assert linear.success and nonlinear_result.success
    fig, axes = plt.subplots(2, 1, figsize=(6.4, 4.5), sharex=True)
    axes[0].plot(t, linear.y[0], label="Linearized")
    axes[0].plot(t, nonlinear_result.y[0], "--", label="Nonlinear")
    axes[0].set(ylabel="Angle deviation (rad)")
    axes[0].legend(fontsize=8)
    axes[1].plot(t, nominal - kp * nonlinear_result.y[0] - kd * nonlinear_result.y[1])
    axes[1].axhline(nominal, color="black", linestyle="--")
    axes[1].set(xlabel="Time (s)", ylabel="Hoop rate (rad/s)")
    for ax in axes:
        ax.grid(alpha=0.25)
    save(fig, "s06b")


if __name__ == "__main__":
    main()
