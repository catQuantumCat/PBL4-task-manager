document.getElementById("add_user").onclick = function() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const email = document.getElementById("email").value;

    const data = {
        username: username,
        password: password,
        email : email
    };

    fetch('http://localhost:5245/backend/account/register', {
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
        alert("Them nguoi dung thanh cong");
    })
    .catch((error) => {
        console.error('Error:', error);
    }); 
}