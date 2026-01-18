import NavBar from "../../components/Header.js";
import { LogoList } from "../../components/ThirdPartyGroup.js";
import { Card } from "../../components/Card.js";

function render() {
    document.getElementById("navbar").innerHTML = NavBar("Login")

    for (let i = 1; i < 6; i++){
        document.getElementById("card-group").innerHTML += Card()
    }
}

render()
