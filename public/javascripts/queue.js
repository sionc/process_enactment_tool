var Queue = (function() {
    // private
    var elements = [];
    var lostElement = null;

    // public
    return {

        enqueue : function(element) {
            if (elements.length == 0) {
                elements[0] = element;
            }
            else if (elements.length == 1) {
                if (elements[0] != element)
                    elements[1] = element;
            }
            else {
                if (elements[1] != element) {
                    // Remove the first
                    lostElement = elements.splice(0, 1)[0];

                    // Append the second
                    elements[1] = element;
                }
            }
        },

        contents : function() {
            return elements;
        },

        lost : function() {
            return lostElement;
        }
    }
});