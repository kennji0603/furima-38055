import consumer from "./consumer"
if(location.pathname.match(/\/items\/\d/)){
  
  consumer.subscriptions.create({
    channel: "CommentChannel",
    item_id: location.pathname.match(/\d+/)[0]
  }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
    // Called when the subscription has been terminated by the server
    },

    received(data) {
      if (data.comment.user_id == data.item.user_id){
        const html = `
          <div class="comment">
            <div class="comment-content">
              <p>${data.comment.text}</p>
            </div>
            <div class="user-info">
              "出品者："+${data.user.nickname}
            </div>
          </div>`
          const comments = document.getElementById("comments")
          comments.insertAdjacentHTML('beforeend', html)
          const commentForm = document.getElementById("comment-form")
          commentForm.reset();
      } else {
        const html = `
          <div class="another-user-comment"> 
            <p class="another-user-info">
              ${data.user.nickname}
            </p>
            <div class="another-user-comment-content"> 
              <p>${data.comment.text}</p>
            </div>  
          </div>`   
        const comments = document.getElementById("comments")
        comments.insertAdjacentHTML('beforeend', html)
        const commentForm = document.getElementById("comment-form")
        commentForm.reset();
      }  
    }
  });
}
