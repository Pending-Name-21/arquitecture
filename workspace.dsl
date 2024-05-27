workspace "Game System" "This system is meant to provide an environment to write games, and run them" {

    model {
        coffeTime = softwareSystem "Coffe Time" "Game Development" {
            bridge = container "Library" "Holds the contract to interact with the backend" {
                piece = component "Piece" "A game is a composition of pieces"
                input_subs = component "Input Subscribers" "Recieves process input stage notifications"
                game = component "Game" "Holds game conditions"
                update_subs = component "Update Subscribers" "Recieves update stage notifications"

                game_loop = component "Game Loop" "Runs the game stages" {}
            }

            console = container "Console" "Console" {
                window_graphics_handler = component "Window Graphics Handler" "Handlers the images/sprites of a window"
                output_handler = component "Output Handler" "In charge of performing output tasks"
                input_handler = component "Input Handler" "Handles input events"
            }
        }

        player = person "Player" "Plays games" {
            this -> coffeTime "Loads games into the console"
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
