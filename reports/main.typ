/////////////
// Imports //
/////////////
#import "@preview/adaptable-pset:0.2.0": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)

/////////////////
// Maths Setup //
/////////////////

// upright vectors
#let vectorboldupright(a) = vb($upright(#a)$)
#let vbu = vectorboldupright
#let vectorunitupright(a) = vu($upright(#a)$)
#let vuu = vectorunitupright
#let vectorarrowupright(a) = va($upright(#a)$)
#let vau = vectorarrowupright

// automatically use square brackets for vectors and matricies
#set math.vec(delim: "[")
#set math.mat(delim: "[")
#let vecrowOld = vecrow
#let vecrow = vecrowOld.with(delim: "[")

////////////////////
// Document Setup //
////////////////////

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

// document settings
#set text(font: "New Computer Modern", size: 10pt)
#set enum(numbering: "a)")

// problem headings
#let probOld = prob
#let prob = prob.with(color: black)

////////////////////////////
// The Assignment Itself: //
// Problems and Solutions //
////////////////////////////

#prob[
    1. Find the coordinates of the vector $vbu(x)^TT = vecrow(-3, 2, 4)$ in the basis given by
        $
            vbu(v)_1 = vec(2, -1, 4) quad
            vbu(v)_2 = vec(-2, 2, 1) quad
            vbu(v)_3 = vec(3, 1, 3)
        $
    <hwk:p01a>

    2. Determine the rank and nullity of $vb(A)$, and a basis for its range and nullspace when
        $
            vb(A) = mat(
                2, 1, 0;
                4, 2, 0;
                6, 3, 0;
            )
        $
    <hwk:p01b>
] <hwk:p01>

1. Coordinates in new basis

We would like scalars $c_1, c_2, c_3$ such that
$
    vbu(x) = c_1 vbu(v)_1 + c_2 vbu(v)_2 + c_3 vbu(v)_3
$

Construct a matrix with the basis vectors as columns:
$
    vb(V) = mat(vbu(v)_1, vbu(v)_2, vbu(v)_3)
    = mat(
        2, -2, 3;
        -1, 2, 1;
        4, 1, 3;
    )
$

Set up change of basis equation:
$
    mat(vbu(v)_1, vbu(v)_2, vbu(v)_3) vec(c_1, c_2, c_3) = vbu(x)
$

Substituting known values:
$
    mat(
        2, -2, 3;
        -1, 2, 1;
        4, 1, 3;
    ) vec(c_1, c_2, c_3) = vec(-3, 2, 4)
$

Row reducing:
$
    mat(
        2, -2, 3, -3;
        -1, 2, 1, 2;
        4, 1, 3, 4;
        augment: #3
    ) ~ mat(
        1, 0, 0, 29/31;
        0, 1, 0, 53/31;
        0, 0, 1, -15/31;
        augment: #3
    )
$

Thus, relative to the ordered basis $cal(B) = vecrow(vbu(v)_1, vbu(v)_2, vbu(v)_3)$,
$
    [vbu(x)]_cal(B) = 1/31 vec(29, 53, -15) quad qed
$

2. Rank, range, nullity, and nullspace

Row reducing $vb(A)$:
$
    vb(A) = mat(
        2, 1, 0;
        4, 2, 0;
        6, 3, 0;
    ) ~ mat(
        1, 1/2, 0;
        0, 0, 0;
        0, 0, 0;
    )
$

There is one pivot and two free variables, so:
$
    rank(vb(A)) = 1 quad qed
$
$
    op("nullity")(vb(A)) = 2 quad qed
$

Regarding the original $vb(A)$ matrix, first column is a pivot column, the second column is half of the first (meaning it can be expressed as a linear combination of the first column), and the third is zero. Thus, the first column forms a basis for its range:
$
    vb(B)_(op("range")(vb(A))) = {vec(2, 4, 6)} quad qed
$

The find the nullspace, we solve:
$
    vb(A) vbu(z) = vb(0)
$

Substituting known values:
$
    2 z_1 + z_2 = 0
$

Choosing $z_2 = 2s$ and $z_3 = t$:
$
    vbu(z) = vec(-s, 2s, t) = s vec(-1, 2, 0) + t vec(0, 0, 1)
$

Thus, a basis for the nullspace is:
$
    vb(B)_(op("nul")(vb(A))) = {vec(-1, 2, 0), vec(0, 0, 1)} quad qed
$

#pagebreak(weak: true)

#prob[
    Using the simple pendulum example from the lectures, suppose $l = 2, m = 1$ (metric units), and $b'(0) = 8$.

    1. Determine the trim input $tau_m^*$ needed to maintain an equilibrium angle $theta^* = pi/3$. Determine the corresponding input-output differential equation that models deviations of the system from this equilibrium.
    <hwk:p02a>

    2. With the input held constant, $tau_m(t) = tau_m^*$ from above, supopse the pendulum is moved to an angle slightly offset from $pi/3$ and released. Make a sketch of the resulting motion of pendulum $theta(t)$. Identify oscillation frequency, damping ratio, and settling time of this response as appropriate.
    <hwk:p02b>
] <hwk:p02>

1. Trim input and deviation equation

Using the supplied lecture model, $z_1 = theta$, $z_2 = dot(theta) = omega$, and $mu = tau_m$. With the damping torque satisfying $b(0) = 0$, the angular equation is:
$
    m l^2 dot.double(theta) + b(dot(theta)) + m g l sin(theta) = tau_m
$
Take $g =$ #qty(9.81, "m/s^2"). At equilibrium, $dot(theta)^* = dot.double(theta)^* = 0$, so:
$
    tau_m^* = m g l sin(theta^*) = 19.62 sin(pi/3)
$
Thus, $tau_m^* =$ #qty(16.9914, "N m"). $quad qed$

Define the output deviation $y = theta - pi/3$ and input deviation $u = tau_m - tau_m^*$. Keeping first-order terms gives:
$
    m l^2 dot.double(y) + b'(0) dot(y) + m g l cos(theta^*) y = u
$
Substituting known values:
$
    4 dot.double(y) + 8 dot(y) + 9.81 y = u
    quad arrow.r quad
    dot.double(y) + 2 dot(y) + 2.4525 y = u/4 quad qed
$

2. Free response about trim

Holding the input at trim means $u = 0$. Comparing the homogeneous equation with $dot.double(y) + 2 zeta omega_n dot(y) + omega_n^2 y = 0$:
$
    omega_n = sqrt(2.4525), quad
    zeta = 1/sqrt(2.4525), quad
    omega_d = omega_n sqrt(1-zeta^2) = sqrt(1.4525)
$
The poles are $-1 plus.minus j sqrt(1.4525)$, so the response is an exponentially decaying oscillation. For release from rest with $y(0) = epsilon$:
$
    theta(t) = pi/3 + epsilon e^(-t)
    (cos(omega_d t) + 1/omega_d sin(omega_d t)) quad qed
$
Here $t$ is in seconds. The oscillation frequency is $omega_d approx 1.2052$ #unit("rad/s") (approximately #qty(0.1918, "Hz")), and $zeta approx 0.6386$. Using the usual 2% settling-time estimate:
$
    t_s approx 4/(zeta omega_n) = 4 quad ("seconds") quad qed
$
The 2% band is relative to the initial displacement, and this formula is an estimate rather than the exact last band crossing.

#figure(
    image("../outputs/figures/s02.png", width: 90%),
    caption: [Linearized release response with $epsilon =$ #qty(0.1, "rad") and zero initial angular speed.],
)

The Python calculation gives:
#raw(read("../outputs/text/s02.txt"), block: true)

#pagebreak(weak: true)

#prob[
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

1. Verification of the reference solution

Substituting $v^* = omega^* = 1$ and $theta^* = t$ into the right-hand sides:
$
    v^* cos(theta^*) = cos(t) = dv(sin(t), t) = dot(p)_x^* \
    v^* sin(theta^*) = sin(t) = dv(1-cos(t), t) = dot(p)_y^* \
    omega^* = 1 = dv(t, t) = dot(theta)^*
$
All three equations hold, with initial state $vec(0, 0, 0)$. Thus, the stated trajectory is a valid solution. $quad qed$

2. Linearization in the original coordinates

Define the state and input deviations:
$
    vbu(x) = vec(p_x-sin(t), p_y-(1-cos(t)), theta-t),
    quad vbu(u) = vec(v-1, omega-1)
$
Taking the state and input Jacobians along the reference trajectory gives:
$
    dot(vbu(x)) = vb(A)(t) vbu(x) + vb(B)(t) vbu(u)
$
where
$
    vb(A)(t) = mat(0, 0, -sin(t); 0, 0, cos(t); 0, 0, 0),
    quad vb(B)(t) = mat(cos(t), 0; sin(t), 0; 0, 1)
$
The coefficients depend explicitly on time, so this linearization is time-varying. $quad qed$

3. Linearization in the alternate coordinates

Differentiate $z_1$ and substitute the original equations:
$
    dot(z)_1 & = dot(p)_x cos(theta) + dot(p)_y sin(theta)
               + dot(theta)(-p_x sin(theta)+(p_y-1)cos(theta)) \
             & = v + omega z_2
$
Similarly,
$
    dot(z)_2 & = -dot(p)_x sin(theta)+dot(p)_y cos(theta)
               -dot(theta)(p_x cos(theta)+(p_y-1)sin(theta)) \
             & = -omega z_1 \
    dot(z)_3 & = omega
$
Along the reference solution:
$
    vbu(z)^*(t) = vec(0, -1, t)
$
Define $vbu(eta) = vbu(z)-vbu(z)^*$ and retain the same input deviations as above. The exact deviation equations are:
$
    dot(eta)_1 & = eta_2 + u_1-u_2 + u_2 eta_2 \
    dot(eta)_2 & = -eta_1-u_2 eta_1 \
    dot(eta)_3 & = u_2
$
Dropping products of deviations:
$
    dot(vbu(eta)) = mat(0, 1, 0; -1, 0, 0; 0, 0, 0) vbu(eta)
    + mat(1, -1; 0, 0; 0, 1) vbu(u) quad qed
$
Both matrices are constant, so the transformed linearization is time-invariant, even though $z_3^* = t$ varies with time.

#pagebreak(weak: true)

#prob[
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

1. Equilibrium points

At equilibrium, $omega^* = 0$ and $dot(omega)^* = 0$. Thus:
$
    sin(theta^*) (a^2-Omega^2 cos(theta^*)) = 0
$
When $Omega^2 < a^2$, the second factor is strictly positive since
$
    a^2-Omega^2 cos(theta^*) >= a^2-Omega^2 > 0
$
Therefore, $sin(theta^*) = 0$. In the principal interval $[-pi, pi]$, the only equilibrium angles are:
$
    theta^* = 0, plus.minus pi, quad omega^* = 0 quad qed
$
Angles are understood modulo $2 pi$; $pi$ and $-pi$ describe the same physical position.

2. Linearized dynamics

Write the nonlinear state equations:
$
    dot(theta) = omega, quad
    dot(omega) = -b omega-a^2 sin(theta)+Omega^2 cos(theta)sin(theta)
$
For $vbu(x) = vec(theta-theta^*, omega)$, the Jacobian gives:
$
    dot(vbu(x)) = vb(A) vbu(x), quad
    vb(A) = mat(0, 1; -k, -b)
$
where
$
    k = a^2 cos(theta^*)-Omega^2 cos(2 theta^*)
$
Evaluating at each equilibrium:
$
    k = cases(
        a^2-Omega^2 & theta^*=0,
        -a^2-Omega^2 & theta^*=plus.minus pi
    ) quad qed
$

3. Local stability

The characteristic equation and eigenvalues are:
$
    lambda^2+b lambda+k = 0, quad
    lambda_(1,2) = (-b plus.minus sqrt(b^2-4k))/2
$
At the bottom, $k = a^2-Omega^2 > 0$. Since $b > 0$, both eigenvalues have negative real parts. Small initial angle and speed deviations decay, and the bead returns to the bottom. The response is underdamped, critically damped, or overdamped according as $b^2$ is less than, equal to, or greater than $4k$. $quad qed$

At the top, $k = -a^2-Omega^2 < 0$. The eigenvalues have opposite signs, so this equilibrium is an unstable saddle. Generic nearby initial conditions diverge from the top. Only initial states on its stable manifold approach it; this exceptional set does not make the equilibrium stable. $quad qed$

#pagebreak(weak: true)

#prob[
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

1. Additional equilibria

The equilibrium condition remains:
$
    sin(theta^*) (a^2-Omega^2 cos(theta^*)) = 0
$
In addition to $0$ and $plus.minus pi$, the second factor now admits:
$
    cos(theta^*) = a^2/Omega^2, quad
    theta^* = plus.minus arccos(a^2/Omega^2) quad qed
$
Since $0 < a^2/Omega^2 < 1$, the new angles satisfy $0 < abs(theta^*) < pi/2$ in the principal interval. Thus, neither new physical equilibrium lies above the horizontal. Adding multiples of $2 pi$ can produce numerical angles greater than $pi/2$, but these describe the same positions.

2. Linearized dynamics

Using the Jacobian found in Problem 4:
$
    vb(A) = mat(0, 1; -k, -b), quad
    k = a^2 cos(theta^*)-Omega^2 cos(2 theta^*)
$
At either new equilibrium, substitute $a^2 = Omega^2 cos(theta^*)$:
$
    k = Omega^2 sin^2(theta^*)
    = Omega^2-a^4/Omega^2 > 0 quad qed
$
For completeness, the original equilibria still have $k(0) = a^2-Omega^2 < 0$ and $k(plus.minus pi) = -a^2-Omega^2 < 0$.

3. Motion near the bottom

At $theta^* = 0$, $k < 0$, so the linearization has one positive and one negative eigenvalue. The bottom is now an unstable saddle: generic small disturbances grow, and the bead does not return to the bottom. As with the top in Problem 4, approach along the stable manifold is exceptional. This differs from Problem 4, where $Omega^2 < a^2$ made the bottom locally asymptotically stable. $quad qed$

4. Rotation rate for the specified equilibrium

Set $theta^* = pi/3$:
$
    a^2 = Omega^2 cos(pi/3) = Omega^2/2
    quad arrow.r quad abs(Omega) = sqrt(2) a
$
Taking the positive rotation rate gives $Omega = sqrt(2) a quad qed$. The opposite rotation direction gives the same equilibrium.

5. Motion near $pi/3$

At the rate found above:
$
    k = Omega^2 sin^2(pi/3) = 2a^2 dot 3/4 = 3a^2/2 > 0
$
With $b > 0$, both eigenvalues have negative real parts. Thus, sufficiently small initial angle and speed deviations converge back to $pi/3$. This is a local conclusion about the nonlinear system, obtained from its asymptotically stable linearization. $quad qed$

#pagebreak(weak: true)

#prob[
    The equations of motion given in #link(<hwk:p04>)[Problem 4] are valid even if the hoop rotation rate $Omega$ is changing with time. Suppose that the nominal rotation rate $Omega^*$ of the hoop is sufficient that the system $theta^* = pi/3$ as an equilibrium point, but now we will directly vary the hoop speed $Omega(t)$ slightly around this nominal value to influence the motion of the bead.

    1. Treating the hoop spin rate $Omega(t)$ as the input to the system, determine the linearized dynamics of the motion of the bead for small displacements from the $theta^* = pi/3$ equilibrium. (You will now have both $vb(A)$ and $vb(B)$ matrices.)
    <hwk:p06a>

    2. Suppose the bead has started sliding with a small inital speed and an initial angle near $pi/3$. We would like to dynamically vary the speed of the hoop so that the bead will settle back to the $theta^* = pi/3$ equilibrium with transient oscillations of #qty(2, "rad/s") and a damping ratio of 0.7. Assuming the bead angle and angular rate of change are measured, specify a feedback control law for $Omega(t)$ which will achieve these objectives.

        #smallcaps[Hint:] A simple PD control strategy for the linearization should be sufficient; for simplicity, you may assume the numerical values $a = 3$ and $b = 0.25$. #emph[Be careful to distinguish $mu(t) = Omega(t)$ from $u(t)$ in your analysis!]
    <hwk:p06b>
] <hwk:p06>

1. Linearization with hoop speed as input

Choose the positive nominal rate $mu^* = Omega^* = sqrt(2) a$. Define:
$
    vbu(x) = vec(theta-pi/3, omega), quad
    mu(t) = Omega(t), quad u(t) = mu(t)-mu^*
$
The nonlinear angular acceleration is:
$
    f(theta, omega, mu) = -b omega-a^2 sin(theta)+mu^2 cos(theta)sin(theta)
$
The input derivative at trim is:
$
    pdv(f, mu) |_* = 2 Omega^* cos(pi/3)sin(pi/3)
    = sqrt(3)/2 Omega^* = sqrt(6)/2 a
$
Using $k = 3a^2/2$ from Problem 5:
$
    dot(vbu(x)) = vb(A) vbu(x)+vb(B) u, quad
    vb(A) = mat(0, 1; -3a^2/2, -b), quad
    vb(B) = vec(0, sqrt(6) a/2) quad qed
$
This is an equation in the input deviation $u$, not the full hoop rate $mu$.

2. PD feedback design

Interpret the specified transient oscillation frequency as the damped frequency $omega_d =$ #qty(2, "rad/s"). For $zeta = 0.7$:
$
    omega_n = omega_d/sqrt(1-zeta^2) = 2/sqrt(0.51), quad
    omega_n^2 = 400/51
$
The desired characteristic polynomial is:
$
    lambda^2+2 zeta omega_n lambda+omega_n^2
    approx lambda^2+3.920784 lambda+7.843137
$
Let $beta = sqrt(6) a/2$ and choose:
$
    u = -K_p x_1-K_d x_2
$
Then
$
    dot.double(x)_1+(b+beta K_d)dot(x)_1+(3a^2/2+beta K_p)x_1 = 0
$
Matching coefficients gives:
$
    K_p = (omega_n^2-3a^2/2)/beta, quad
    K_d = (2 zeta omega_n-b)/beta
$
With $a = 3$ and $b = 0.25$, the Python calculation gives:
#raw(read("../outputs/text/s06b.txt"), block: true)

Thus, the commanded physical hoop speed is:
$
    Omega(t) = Omega^*-K_p lr(theta(t)-pi/3)-K_d omega(t)
$
Numerically, with angles in radians and time in seconds:
$
    Omega(t) approx 4.242641+1.539603(theta(t)-pi/3)-0.999061 omega(t) quad qed
$
The proportional gain $K_p$ is negative because the requested stiffness $omega_n^2$ is smaller than the uncontrolled stiffness $3a^2/2 = 13.5$. The derivative term increases damping. The resulting poles are $-1.960392 plus.minus 2j$, which give the specified damped frequency and damping ratio.

These targets apply to the local linearization. As a numerical check, apply the same feedback to the original nonlinear equations with $theta(0)-pi/3 =$ #qty(0.02, "rad") and $omega(0) =$ #qty(0.01, "rad/s"):

#figure(
    image("../outputs/figures/s06b.png", width: 90%),
    caption: [Linear and nonlinear responses under the PD law, and the commanded nonlinear hoop rate.],
)

#pagebreak(weak: true)

== Code

#codly(header: [./src/index.py])
#raw(read("../src/index.py"), block: true, lang: "python") <hwk:code>
