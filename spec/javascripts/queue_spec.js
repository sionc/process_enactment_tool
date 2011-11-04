describe("Queue", function() {

    it("can store one element",
    function() {
        var queue = Queue();
        queue.enqueue('apple');
        expect(queue.contents()).toEqual(['apple']);
    });
  	
    it("can store two elements",
    function() {
        var queue = Queue();
        queue.enqueue('apple');
        queue.enqueue('pear');
        expect(queue.contents()).toEqual(['apple', 'pear']);
    });

    it("should discard the first element when two more are added",
    function() {
        var queue = Queue();
        queue.enqueue('apple');
        queue.enqueue('pear');
        queue.enqueue('apricot');
        expect(queue.contents()).toEqual(['pear', 'apricot']);
    });

    it("should save the last element that was lost",
    function() {
        var queue = Queue();
        queue.enqueue('apple');
        queue.enqueue('pear');
        queue.enqueue('apricot');
        expect(queue.lost()).toEqual('apple');
    });

});
