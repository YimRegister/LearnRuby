document.addEventListener('DOMContentLoaded', function() {
 
  document.getElementById('generate_image').addEventListener('click', function(event) {
      event.preventDefault(); // Prevent default form submission
      const prompt = document.getElementById('prompt').value;
      // Send an AJAX request to the controller action
      fetch(`/home?prompt=${prompt}`)
        .then(response => response.text())
        .then(data => console.log(data)) // Handle the response data here
        .catch(error => console.error('Error:', error));
      }
   ) });
  

   