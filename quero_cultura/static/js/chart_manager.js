function createFrame(graphicURL, locationId){
    var frame = '<iframe \
      src="' + graphicURL + '" \
      frameborder="0" \
      width="90%" \
      height="600px" \
      allowtransparency \
    ></iframe>'
    $(locationId).append(frame)
}
