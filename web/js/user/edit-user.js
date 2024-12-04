import UpdateRequestUserDto from "../../dtos/user/UpdateRequestUserDto.js";
import UserRepository from "../../repository/UserRepository.js";

const userRepo = new UserRepository("http://localhost:5245/backend/account/editUser");

const urlParams = new URLSearchParams(window.location.search);
const username = urlParams.get('username').replace(/'/g, '');

let allUsers = [];

allUsers = await userRepo.getAllUsers();

const editUser = allUsers.find((user) => (user).userName === username);

document.getElementById("username").value = editUser.userName;
document.getElementById("email").value = editUser.email;

document.getElementById("edit_user").onclick = function() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const email = document.getElementById("email").value;   

    const user = new UpdateRequestUserDto({username, email, password});

    userRepo.editUser(user)
    .then(data => {
        console.log('Success:', data);
        alert("Sua nguoi dung thanh cong");
        parent.frames['content'].location.href = "../../html/user/user-manager.html";
    })
    .catch((error) => {
        console.error('Error:', error);
    }); 
}