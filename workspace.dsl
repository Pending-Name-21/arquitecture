workspace "Game System" "This system is meant to provide an environment to write games, and run them" {

    model {
        coffeTime = softwareSystem "Coffe Time" "Game Development" {
            server = container "Socket server" "Recieves data" {
                socket_server = component "Socket server" "Recieves data"
            }
            screen = container "Screen" "Handles the output of a game such as graphics or sound" {
                s_socket_client = component "Socket Client" "Sends data" {
                    this -> socket_server "sends input data"
                }
                s_socket_server = component "Socket Server" "Recieves data"

                input_monitor = component "Input device monitor" "Listens for input devices events" {
                    this -> s_socket_client "Registers input device events"
                }
                sound_manager = component "Sound Manager" "Manages sound operations such as reproduction" {
                    this -> s_socket_server "Waits for data"
                    s_socket_server -> this "Delivers data"
                }
                gui = component "GUI" "Renders content to the screen" {
                    this -> s_socket_server "Waits for data"
                    s_socket_server -> this "Delivers data"
                }
            }
            console = container "Console" "Library to perform low-level operations" {
                c_socket_client = component "Socket Client" "Sends data" {
                    this -> s_socket_server "sends output data"
                }
                output_intermediate = component "Output intermediate" "Routines to send data" {
                    this -> c_socket_client "writes output data"
                }
                input_intermediate = component "Input intermediate" "Routines to read input events" {
                    this -> socket_server "reads for input events"
                }
            }


            bridge = container "Bridge" "Represents the contract to interact with the console" {
                this -> console "calls routines to handle low-level operations"

                render_handler = component "Render handler" "Responsible for the graphical components of the game" {
                    this -> output_intermediate "Sends output data"
                }
                process_input_handler = component "Process input handler" "Responsible for processing input events" {
                    this -> input_intermediate "sends a request for input events"
                }
                game_settings = component "Game Settings" "It's where the game settings reside"
                update_handler = component "Update Handler" "Handles update stage events"
                game_loop = component "Game Loop" "Runs the game stages" {
                    this -> process_input_handler "Sends a process_input stage event"
                    this -> render_handler "Sends a render stage event"
                    this -> update_handler "Sends a update_stage event"
                    this -> game_settings "Checks for conditions that affect the loop"
                }
            }
        }

        player = person "Player" "Plays games" {
            this -> coffeTime "Loads games"
        }

        gameDev = person "Game developer" "A developer that want's to create new games" {
            this -> bridge "Writes games"
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
