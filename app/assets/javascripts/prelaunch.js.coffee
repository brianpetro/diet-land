$ -> #run when the DOM is ready
  $(".btn").click -> #use a class, since your ID gets mangled
    $(this).addClass "disabled" #add the class to the clicked element
