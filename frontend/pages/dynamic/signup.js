import NavBar from "../../components/Header.js";
import { LogoList } from "../../components/ThirdPartyGroup.js";

function render() {
    document.getElementById("sign-up").innerHTML = NavBar("Signup")
    document.getElementById("icon-3rd").innerHTML = LogoList()
}

render()
