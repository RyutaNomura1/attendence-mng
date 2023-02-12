  window.addEventListener('load', function(){
  
  const kindOfFollowModals = ["follower","following"]
  for (let i = 0; i < kindOfFollowModals.length ; i++){
  let kindOfFollowModal = kindOfFollowModals[i];
  
    const followModalOpen = document.querySelector(`#${kindOfFollowModal}-modal-open`);
    const followModalClose = document.querySelector(`#${kindOfFollowModal}-modal-close`);
    const followModal = document.querySelector(`#${kindOfFollowModal}-modal`);
    
    followModalOpen.addEventListener("click", ()=>{
      followModal.style.display = "block";
    });
    followModalClose.addEventListener("click", ()=>{
      followModal.style.display = "none";
      window.location.reload();
    });
    document.addEventListener("click", (e)=>{
      if(e.target == followModal ){
        followModal.style.display = "none";
        window.location.reload();
      }
    });
  }
  })