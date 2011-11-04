var Queue = (function() {
    // private
    var elements = [];

    // public
    return {

        enqueue : function(element) {
            if (elements.length == 0) {
                elements[0] = element;
            }
            else if (elements.length == 1) {
                elements[1] = element;
            }
            else {
                // Remove the first
                elements.splice(1, 1);

                // Append the second
                elements[1] = element;
            }
        },

        contents : function() {
            return elements;
        }
    }
});