import numpy as np
import matplotlib.pyplot as plt


def heading(problem):
    print(f"\n------\n {problem}\n------")


def main():
    #########
    # p02 #
    #########
    heading("p02")

    x = np.linspace(0, 10, 100)
    y = np.sin(x)

    print(f"x:\n{x}\n\ny:\n{y}")
    # with open("./outputs/text/s02.txt", "w", encoding="utf-8") as f:
    #     f.write(f"x:\n{x}\n\ny:\n{y}")

    plt.figure()
    plt.plot(x, y)

    # plt.savefig("./outputs/figures/s02.png")
    plt.show()


if __name__ == "__main__":
    main()
