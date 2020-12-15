import Swal from 'sweetalert';

const initSweetalert = () => {
  const alertBox = document.querySelector('.alert')
  if (alertBox){
  const icon = alertBox.classList.contains('alert-info') ? "success" : "warning"
  const title = alertBox.classList.contains('alert-info') ? "Success" : "Oops..."
  Swal('#sweet-alert', {
    title: title,
    text: alertBox.innerText,
    icon: icon,
    button: "Continue",
  });

  }
};

export { initSweetalert };
