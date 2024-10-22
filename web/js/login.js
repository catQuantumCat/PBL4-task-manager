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
