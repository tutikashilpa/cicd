import psutil
import lib1.libapp


def main():
    print(psutil.cpu_times())
    print("Hello ")

if __name__ == "__main__":
    main()