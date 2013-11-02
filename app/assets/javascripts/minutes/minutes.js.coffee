$(document).ready ->
  $("#new_minutes_minute").bind "ajax:error", (e, xhr, status, error) ->
    console.log "errrorrr"
    response = JSON.parse xhr.responseText
    for element, error_text of response.errors
      dom_element = $("#minutes_minute_" + element)

      if(dom_element.hasClass("select2-offscreen"))
        dom_element.on("select2-focus", clearError)
        dom_element = $("#s2id_minutes_minute_" + element)
        dom_element.addClass("error").after("<small class=\"error\">#{error_text[0]}</small>")
      else
        dom_element.addClass("error").after("<small class=\"error\">#{error_text[0]}</small>")
        dom_element.focus(clearError)
  $("#new_minutes_minute").bind "ajax:success", (e, data, status, xhr) ->
    console.log("tadda")
    response = JSON.parse xhr.responseText
    window.location.href = response.forward_to

  $(".select2-field select").select2()
 
  # Clear errors on submit
  $("form.new_minutes_minute").submit () -> 
    $("input.error").each clearError
    $(".select2-container.error").each clearError
    $("input[name=commit]").html("value", "Speichere " + global.spinner_image)

clearError = () ->
  el = this
  if($(el).hasClass("select2-offscreen"))
    el = "#s2id_" + $(el).attr("id")
  $(el).removeClass("error")
  $(el).next(".error").detach()