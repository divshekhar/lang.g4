# class Display
class Display:
    def __init__(self, string: str):
        self.__name = string

    def __str__(self):
        return self.__name


# class Hello
class Hello(Display):
    def __init__(self, string: str):
        super().__init__(string)

    def __str__(self) -> str:
        return super().__str__()


if __name__ == "__main__":
    # print("Hello World")
    # printHelloWorld()
    hello = Hello("Hello World")
    print(hello)
