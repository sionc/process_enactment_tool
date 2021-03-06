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
                if (elements[0] != element)
                    elements.unshift(element);
            }
            else {
                if (elements[0] != element) {
                    // Remove the second
                    elements.splice(1, 1)[0];

                    // Prepend the new element
                    elements.unshift(element);
                }
            }
        },

        contents : function() {
            return elements;
        }
    }
});