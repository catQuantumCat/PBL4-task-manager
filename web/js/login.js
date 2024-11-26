import LoginDto from "../dtos/login/LoginDto.js";
import LoginRepository from "../repository/LoginRepository.js";

const loginContainer = document.querySelector('.login-container');
const signupContainer = document.querySelector('.signup-container');
const switchLinks = document.querySelectorAll('.switch');

switchLinks.forEach(link => {
    link.addEventListener('click', (event) => {
        event.preventDefault();
        loginContainer.style.display = loginContainer.style.display === 'none' ? 'block' : 'none';
        signupContainer.style.display = signupContainer.style.display === 'none' ? 'block' : 'none';
    });
});

document.getElementById("login").onclick = function() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;

    const loginDto = new LoginDto({username, password});

    const loginRepo = new LoginRepository();
    
    loginRepo.Login(loginDto)
    .then(data => {
        console.log('Success:', data);
        window.location.href = "../admin.html"
    })
    .catch((error) => {
        console.error('Error:', error);
    });    
}

