workspace "Game System" "This system is meant to provide an environment to write games, and run them"{

    model {
        gameDev = person "Game developer" "A developer that want's to create new games"
        frontend = softwareSystem "Frontend" "It's the game representation" {
            piece = container "Piece" "It's the main part" {
                sprite = component "Sprite" "It's an image"
                sound = component "Sound"
                collisionShape = component "Collision Shape" "It's the borders of the image that can interact with other sprites"
            }

            subscriptions = container "Subscriptions" "Manages the subscription to events" {
                mouse = component "Mouse Event" "Related to any mouse interactions"
                keyboard = component "Keyboard Event" "Related to any keyboard interactions"
                collision = component "Collision Event" "Related to the interactions between two or more sprites"
                soundEvent = component "Sound manager" "Handles sound events"
                piece -> this "subscribes elements"
            } 

            gameDev -> this "writes games"
        }

        backend = softwareSystem "Backend" "Responsible for reading the game instructions" {
            core = container "Core" "Handles the game" {
                game_loop = component "Game Loop" "Handles the execution of the main game loop" 
            }

            graphicsEngine = container "Graphics Engine" "Handles everything related to the graphics"

            notifications = container "Notifications" "Notifies the frontend about certain events" {
                mousePublisher = component "Mouse publisher" "Sends mouse events notifications"
                keyboardPublisher = component "Keyboard publisher" "Sends Keyboard events notifications"
                soundHandler = component "Sound Handler" "handles sound events" 
                collisionsPublisher = component "Collisions Publisher" "Sends notifications when two or more sprites collide"
            }

            this -> frontend "Executes the game using foreign function interface"
            core -> notifications "Fires notifications"
            core -> graphicsEngine "Updates the graphics"
        }
        player = person "Player" "Plays games" {
            this -> backend "Loads games into the console"
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
