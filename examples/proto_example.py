"""In this example we are just loading a protocol buffer generated message."""
from examples.proto.game_event_pb2 import GameMessage


def main():
    game_event = GameMessage()
    game_event.game_id = 123
    game_event.game_mode = "ARAM"
    print(game_event)


if __name__ == "__main__":
    main()
