workspace "Game System" "This system is meant to provide an environment to write games, and run them"{

    model {
        gameDev = person "Game developer" "A developer that want's to create new games"
        gameSystem = softwareSystem "Game system" "Is the game representation" {
            piece = container "Piece" "It's the main part" {
                sprite = component "Sprite" "It's an image"
                sound = component "Sound"
                collisionShape = component "Collision Shape" "It's the borders of the image that can interact with other sprites"
            }

            subscriptionsManager = container "Subscriptions Manager" "Manages the subscription to events" {
                mouse = component "Mouse Event" "Related to any mouse interactions"
                keyboard = component "Keyboard Event" "Related to any keyboard interactions"
                collision = component "Collision Event" "Related to the interactions between two or more sprites"
                soundEvent = component "Sound manager" "Handles sound events"
                
                piece -> this "subscribes elements"
            } 

            game = container "Game" {
                core = component "Core" "It's the main loop"
            }


            gameDev -> this "writes games"
        }

        consoleSystem = softwareSystem "Console System" "Executes a game"{
            interpreter = container "Interpreter" "Reads a bunch of tokens and delivers instructions"
            lexer = container "Lexer" "Reads a stream of chars and outputs a list of tokens"

            graphicsEngine = container "Graphics Engine" "Handles everything related to the graphics"
            input_ouput = container "I/O" "Handles keyboard and mouse events" {
                mousePublisher = component "Mouse publisher" "Sends mouse events notifications"
                keyboardPublisher = component "Keyboard publisher" "Sends Keyboard events notifications"
                soundHandler = component "Sound Handler" "handles sound events" 
            }

            lexer -> interpreter "delivers an array of tokens"
            interpreter -> input_ouput "delivers instructions"
            interpreter -> graphicsEngine "delivers instructions"
            this -> gameSystem "reads instructions about how to run the game"
        }
    }

    views {
        styles {
            element "Person" {
                shape Person
            }
        }
    }
}
