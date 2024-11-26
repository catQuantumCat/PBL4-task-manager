export default class LoginRepository {
    async Login(loginDto) {
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
            return response.json();
        })
    }
}