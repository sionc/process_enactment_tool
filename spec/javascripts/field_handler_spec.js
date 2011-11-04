describe("FieldHandler", function() {

    it("should return that no field is disabled when no fields have been modified",
    function() {
        var fieldHandler = FieldHandler();
        expect(fieldHandler.getDisabledField()).toEqual(null);
    });

    it("should return that no field is disabled when one field has been modified",
    function() {
        var fieldHandler = FieldHandler();
        fieldHandler.modifyEstimatedSize();
        expect(fieldHandler.getDisabledField()).toEqual(null);
    });  	
    
});
