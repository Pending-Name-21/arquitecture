workspace "Game System" "This system is meant to provide an environment to write games, and run them"{

    model {
        frontend = softwareSystem "Frontend" "It's the game representation" {
            library = container "Library" "Holds the contract to interact with the backend" {
                piece = component "Piece" "A game is a composition of pieces"
                input_subs = component "Input Subscribers" "Recieves process input stage notifications" 
                game = component "Game" "Holds game conditions"
                update_subs = component "Update Subscribers" "Recieves update stage notifications" 
            }

        }

        backend = softwareSystem "Backend" "Responsible for handling the game" {
            this -> frontend "Performs the game instructions"

            publisher = container "Publisher" "Notifies the frontend" {
                notifier = component "Notifier" "Sends notifications to the frontend"
                notifier -> frontend "Notifies subscribers"
            }

            sprites_handler = container "Sprites handler" "Manages Sprites" {
                window_graphics_handler = component "Window Graphics Handler" "Handlers the images/sprites of a window"
                sh_scanner = component "Scanner" "Scans sprites coordinates"

                sh_scanner -> piece "Iterates through sprites and collects sprite's coordindates data"
                sh_scanner -> window_graphics_handler "Feeds data"
            }

            output_handler = container "Output Handler" "In charge of performing output tasks" {
                sound = component "Sound" "Plays sounds"
                oh_scanner = component "Scanner" "Scans for output conditions"

                oh_scanner -> piece "Looks for any output requirement"
                oh_scanner -> sound "Request the play of true output sounds"
            }

            input_handler = container "Input Handler" "Handles input events" {
                mouse = component "Mouse" "Registers mouse events"
                keyboard = component "Keyboard" "Registers keyboard events"

                mouse -> publisher "Sends an array of mouse events to be published"
                keyboard -> publisher "Sends an array of keyboard events to be published"
            }

            game_handler = container "Game Handler" "Handles the execution of the game" {
                game_loop = component "Game Loop" "Runs the game stages" {
                    this -> input_handler "starts a check for input sequence"
                    this -> notifier "request update subscribers to be notified"
                    this -> sh_scanner "starts a data reading request"
                    this -> oh_scanner "starts a data reading request"
                    this -> game "checks if game can still run"
                }
            }
        }

        player = person "Player" "Plays games" {
            this -> backend "Loads games into the console"
        }

        gameDev = person "Game developer" "A developer that want's to create new games" {
            this -> library "Writes games"
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
