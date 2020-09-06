if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {

  document.addEventListener('DOMContentLoaded', function(){
    const imageList = document.getElementById('image-list');
    document.getElementById('preview').addEventListener('change', function(e){

      const imageContent = document.querySelector('img');
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      const imageElement = document.createElement('div');

      const blobImage = document.createElement('img');
      blobImage.setAttribute('src', blob);
      blobImage.style.height = "100px";
      blobImage.style.width = "100px";

      imageElement.appendChild(blobImage);
      imageList.appendChild(imageElement);
    });
  });

}  