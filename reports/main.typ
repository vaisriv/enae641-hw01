#import "@preview/adaptable-pset:0.2.0": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.1": *

// upright vectors
#let vectorboldupright(a) = vb($upright(#a)$)
#let vbu = vectorboldupright
#let vectorunitupright(a) = vu($upright(#a)$)
#let vuu = vectorunitupright
#let vectorarrowupright(a) = va($upright(#a)$)
#let vau = vectorarrowupright

// assignment info
#show: homework.with(
    title: "HW01",
    author: "Vai Srivastava",
    collaborators: [],
    course-id: "ENAE 641: Linear System Dynamics",
    instructor: "Dr. Robert Sanner",
    semester: "Fall 2026",
    due-time: "September 24th. at 23:59",

    // (defaults to A4)
    paper-size: "us-letter",
)

#set text(font: "New Computer Modern", size: 10pt)
#set enum(numbering: "a)")

#prob(color: black)[
    1. Find the coordinates of the vector $vbu(x)^TT = vecrow(-3, 2, 4, delim: "[")$ in the basis given by
        $
            vbu(v)_1 = vec(2, -1, 4, delim: "[") quad
            vbu(v)_2 = vec(-2, 2, 1, delim: "[") quad
            vbu(v)_3 = vec(3, 1, 3, delim: "[")
        $
    <hwk:p01a>

    2. Determine the rank and nullity of $vb(A)$, and a basis for its range and nullspace when
        $
            vb(A) = mat(
                2, 1, 0;
                4, 2, 0;
                6, 3, 0;
                delim: "["
            )
        $
    <hwk:p01b>
] <hwk:p01>

// Note that $r equiv abs(vbu(r))$ and $dot(vbu(r)) equiv vbu(v)$:
// $ vbu(r) dprod vbu(v) = abs(vbu(r)) dot(r) $
//
// Rearrange, with $r > 0$:
// $ dot(r) = (vbu(r) dprod vbu(v))/abs(vbu(r)) $
//
// Note that $vbu(r)/abs(vbu(r)) equiv vuu(r)$:
// $ (vbu(r) dprod vbu(v))/abs(vbu(r)) = vuu(r) dprod vbu(v) $
//
// From Eq. 2.7:
// $ vuu(u)_r = vbu(r)/r = vbu(r)/abs(vbu(r)) = vuu(r) $
//
// Thus:
// $ dot(r) = vuu(u)_r dprod vbu(v) $
//
// The dot product is commutative, so:
// $ dot(r) = vuu(u)_r dprod vbu(v) = vbu(v) dprod vuu(u)_r $
//
// We now have:
// $ dot(r) = vbu(v) dprod vuu(u)_r quad qed $
//
// The dot product projects the velocity onto the outward radial direction. Thus, $dot(r)$ is the radial component of velocity: it is positive when the spacecraft moves away from the attracting body, negative when it moves toward it, and zero when the velocity is perpendicular to the radius. A zero radial velocity does not imply that the spacecraft is stationary.

#pagebreak(weak: true)

#prob(color: black)[
    Using the simple pendulum example from the lectures, suppose $l = 2, m = 1$ (metric units), and $b'(0) = 8$.

    1. Determine the trim input $tau_m^*$ needed to maintain an equilibrium angle $theta^* = pi/3$. Determine the corresponding input-output differential equation that models deviations of the system from this equilibrium.
    <hwk:p02a>

    2. With the input held constant, $tau_m(t) = tau_m^*$ from above, supopse the pendulum is moved to an angle slightly offset from $pi/3$ and released. Make a sketch of the resulting motion of pendulum $theta(t)$. Identify oscillation frequency, damping ratio, and settling time of this response as appropriate.
    <hwk:p02b>
] <hwk:p02>

// TODO: answer

#pagebreak(weak: true)

#prob(color: black)[
    Consider a kinematic model of a unicycle maneuvering in a plane:
    $
          dot(p)_x & = v cos(theta) \
          dot(p)_y & = v sin(theta) \
        dot(theta) & = omega
    $
    Where $(p_x, p_y)$ describes the location of the unicycle, and $theta$ is its orientation; linear velocity $v$ and angular velocity $omega$ are regarded as the "inputs" to this kinematic model.

    1. Show that $omega(t) = v(t) = 1$, $p_x(t) = sin(t)$, $p_y(t) = 1 - cos(t)$, and $theta(t) = t$ is a valid solution of these equations.
    <hwk:p03a>

    2. Determine the linear state equations for perturbations away from the reference solution in #link(<hwk:p03a>)[Part A]. Is the linearization time-invariant or time-varying?
    <hwk:p03b>

    3. Repeat #link(<hwk:p03b>)[Part B] but using instead the following alternate choice of state variables:
        $
            z_1 & = p_x cos(theta) + (p_y - 1) sin(theta) \
            z_2 & = -p_x sin(theta) + (p_y - 1) cos(theta) \
            z_3 & = theta
        $
        #smallcaps[Hint:] You'll need to first find the nonlinear state equation corresponding to this choice of state variables, then apply the linearization process in these new coordinates.
    <hwk:p03c>
] <hwk:p03>

// TODO: answer

#pagebreak(weak: true)

#prob(color: black)[
    A bead is constrained to move on a vertical, circular hoop of radius $R$. There is non-negligible friction between the bead and the hoop, creating some damping in the motion of the bead. The hoop itself is spinning about its vertical axis at a constant angular rate of $Omega$ #unit("rad/s"). Let $theta$ be the angular position (#unit("rad")) of the bead on the hoop, measured from the local vertical (down), and let $omega = dv(theta, t)$ be the rate of change of this angle (#unit("rad/s")). The differential equation modeling the motion fo the bead is then
    $
        dot(omega)(t) + b omega(t) + a^2 sin(theta(t)) = Omega^2 cos(theta(t)) sin(theta(t))
    $
    where $b > 0$ is a proportional damping coefficient, and $a^2 = g/R$ where $g$ is the gravitational acceleration (#unit("m/s^2")).

    1. Suppose that $Omega^2 < a^2$. Show that, like the simple, unforced ($mu^* = 0$) pendulum example considered in class, $theta^* = 0$ and $theta^* = plus.minus pi$ are the only possible equilibrium points for this system.
    <hwk:p04a>

    2. Show that the linearized dynamics of the bead angle for small displacements from the equilibria considered in #link(<hwk:p04a>)[Part A] have an $vb(A)$ matrix of the form:
        $
            vb(A) = mat(0, 1; -k, -b; delim: "[")
        $
        Give an explicit expression for $k$ in terms of $a$ and $Omega$ for each of the equilibrium points in #link(<hwk:p04a>)[Part A]. (There is no input, hence no $vb(B)$ matrix in this problem.)
    <hwk:p04b>

    3. If the bead is started sliding with a small initial speed at an initial angle near, but not at, each of the equilibrium angles in #link(<hwk:p04a>)[Part A], will the bead tend to return to, or diverge from, that angle? Explain your answers.
    <hwk:p04c>
] <hwk:p04>

// TODO: answer

#pagebreak(weak: true)

#prob(color: black)[
    Suppose in #link(<hwk:p04>)[Problem 4] that the hoop is spinning faster so that $Omega^2 > a^2$.

    1. Show that bead can have new equilibrium points $theta^*$ in addition to those identified in #link(<hwk:p04>)[Problem 4]. Can any of these new equilibrium points satisfy $theta^* > pi/2$ (#unit("rad"))? Why or why not?
    <hwk:p05a>

    2. Show that the $vb(A)$ matrix for the linearized dynamics about each of the equilibrium points in #link(<hwk:p05a>)[Part A] has the same structure identified above, and determine the new value for $k$ in terms of $a$, $Omega$, and $theta^*$.
    <hwk:p05b>

    3. Suppose the bead has started sliding with a small initial speed and an initial angle near, but not at, zero (i.e. the bead starts near the bottom of the hoop). Will the bead tend to slide down to the bottom of the hoop (i.e. converge to the $theta^* = 0$ equilibrium)? Compare your answer with #link(<hwk:p04c>)[Problem 4, Part C].
    <hwk:p05c>

    4. As a function of $a$, find the value of $Omega$ such that the bead will have $theta^* = pi/3$ as an equilibrium point.
    <hwk:p05d>

    5. Suppose the bead has started sliding with a small initial speed and an initial angle near $pi/3$. Will the bead tend to converge back to a stead-state angle of $pi/3$? Explain your answer.
    <hwk:p05e>
] <hwk:p05>

// TODO: answer

#pagebreak(weak: true)

#prob(color: black)[
    The equations of motion given in #link(<hwk:p04>)[Problem 4] are valid even if the hoop rotation rate $Omega$ is changing with time. Suppose that the nominal rotation rate $Omega^*$ of the hoop is sufficient that the system $theta^* = pi/3$ as an equilibrium point, but now we will directly vary the hoop speed $Omega(t)$ slightly around this nominal value to influence the motion of the bead.

    1. Treating the hoop spin rate $Omega(t)$ as the input to the system, determine the linearized dynamics of the motion of the bead for small displacements from the $theta^* = pi/3$ equilibrium. (You will now have both $vb(A)$ and $vb(B)$ matrices.)
    <hwk:p06a>

    2. Suppose the bead has started sliding with a small inital speed and an initial angle near $pi/3$. We would like to dynamically vary the speed of the hoop so that the bead will settle back to the $theta^* = pi/3$ equilibrium with transient oscillations of #qty(2, "rad/s") and a damping ratio of 0.7. Assuming the bead angle and angular rate of change are measured, specify a feedback control law for $Omega(t)$ which will achieve these objectives.

        #smallcaps[Hint:] A simple PD control strategy for the linearization should be sufficient; for simplicity, you may assume the numerical values $a = 3$ and $b = 0.25$. #emph[Be careful to distinguish $mu(t) = Omega(t)$ from $u(t)$ in your analysis!]
    <hwk:p06b>
] <hwk:p06>
