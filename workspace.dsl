workspace "Game System" "This system is meant to provide an environment to write games, and run them" {

    model {
        coffeTime = softwareSystem "Coffe Time" "Game Development" {
            console = container "Console" "Responsible for Low Level operations" {
                input_listener = component "Input listener" "Listens for keyboard and mouse events"
                output_handler = component "Output Handler" "Handles output event requests"
                gui_manager = component "GUI Manager" "Renders content to the screen"
            }

            bridge = container "Bridge" "Represents the contract to interact with the console" {
                this -> console "calls routines to handle low-level operations"

                render_handler = component "Render handler" "Responsible for the graphical components of the game" {
                    this -> gui_manager "Sends data to render"
                    this -> output_handler "Sends output requests"
                }
                process_input_handler = component "Process input handler" "Responsible for processing input events" {
                    this -> input_listener "sends a request for input events"
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
