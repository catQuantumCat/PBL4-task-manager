export default class LoginRepository {
    async Login(loginDto) {
        console.log(JSON.stringify(loginDto));
        fetch('http://localhost:5245/backend/account/loginadmin', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(loginDto) 
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            if(response.status === 200) {
                window.location.href = "../index.html";
            }
        })
        .then(data => {
            console.log(data);
        })
        .catch((error) => {
            console.error('Error:', error);
            alert("Đăng nhập thất bại");
            window.location.href = "../login/login.html";
        });    
    }
}