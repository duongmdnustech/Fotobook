import NavBar from "../../components/Header.js";
import { LogoList } from "../../components/ThirdPartyGroup.js";

function render() {
    document.getElementById("login").innerHTML = NavBar("Login")
    document.getElementById("icon-3rd").innerHTML = LogoList()
}

render()
