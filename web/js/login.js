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

    const data = {
        username: username,
        password: password
    };

    fetch('http://localhost:5245/backend/account/loginadmin', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data) 
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        console.log('Success:', data);
        window.location.href = "../admin.html"
    })
    .catch((error) => {
        console.error('Error:', error);
    });    
}

