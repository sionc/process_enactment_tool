/**
 * Created by JetBrains RubyMine.
 * User: cool_curly
 * Date: 11/3/11
 * Time: 10:23 PM
 * To change this template use File | Settings | File Templates.
 */

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

    it("discards the first element when two more are added",
    function() {
        var queue = Queue();
        queue.enqueue('apple');
        queue.enqueue('pear');
        queue.enqueue('apricot');
        expect(queue.contents()).toEqual(['pear', 'apricot']);
    });

});
