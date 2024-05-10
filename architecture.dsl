
workspace "Game System" "This system is meant to provide an environment to write games, and run them"{

    model {
        gameDev = person "Game developer" "A developer that want's to create new games"
        gameSystem = softwareSystem "Game system" "Is the game representation" {
            game = container "Game" "It's a collection of components used to create the game" {
                sprite = component "Sprite" "It's an image"
                sound = component "Sound"
                collisionShape = component "Collision Shape" "It's the borders of the image that can interact with other sprites"
            }

            subscriptionsManager = container "Subscriptions Manager" "Manages the subscription to events" {
                mouse = component "Mouse Event" "Related to any mouse interactions"
                keyboard = component "Keyboard Event" "Related to any keyboard interactions"
                collision = component "Collision Event" "Related to the interactions between two or more sprites"
            } 
        }

        consoleSystem = softwareSystem "Console System" "Executes a game"{
            core = container "Core" "Reads the game and delivers instructions" {
                interpreter = component "Interpreter" "Reads a bunch of tokens and delivers instructions"
                lexer = component "Lexer" "Reads a stream of chars and outputs a list of tokens"
            }

            graphicsEngine = container "Graphics Engine" "Handles everything related to the graphics"
            input-ouput = container "I/O" "Handles keyboard and mouse events" {
                mousePublisher = component "Mouse publisher" "Sends mouse events notifications"
                keyboardPublisher = component "Keyboard publisher" "Sends Keyboard events notifications"
                soundHandler = component "Sound Handler" "handles sound events" 
            }
        }

        #
        # Relationships
        #
        # Person
        gameDev -> gameSystem "writes games"

        # System context
        consoleSystem -> gameSystem "reads instructions about how to run the game"

        # Console System
        core -> input-ouput "delivers instructions"
        core -> graphicsEngine "delivers instructions"

        # Core container
        lexer -> interpreter "delivers an array of tokens"

    }

    views {
        styles {
            element "Person" {
                shape Person
            }
        }
    }
}
