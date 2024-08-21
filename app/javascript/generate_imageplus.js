document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('generate_imageplus').addEventListener('click', function(event) {
        event.preventDefault(); // Prevent default form submission
        const noun = document.getElementById('noun').value;
        const descriptor = document.getElementById('descriptor').value;
        const verb = document.getElementById('verb').value;

        const prompt = noun + descriptor + verb;
        
       
        
        
        // Send an AJAX request to the controller action
        fetch(`/home?prompt=${prompt}`)
          .then(response => response.text())
          .then(data => console.log(data)) // Handle the response data here
          .catch(error => console.error('Error:', error));
        }
     ) });
    