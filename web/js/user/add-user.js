import AddRequestUserDto from "../../dtos/user/AddRequestUserDto.js";
import UserRepository from "../../repository/UserRepository.js";

document.getElementById("add_user").onclick = function() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const email = document.getElementById("email").value;
    
    const user = new AddRequestUserDto({username, email, password});

    const userRepo = new UserRepository("http://localhost:5245/backend/account/register");
    
    userRepo.addUser(user)
    .then(data => {
        console.log('Success:', data);
        alert("Them nguoi dung thanh cong");
    })
    .catch((error) => {
        console.error('Error:', error);
    }); 
}