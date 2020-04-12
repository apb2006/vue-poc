/**
 * @author andy bunce
 * @description visit sequence of pages
 */

describe('visit-all', function () {
    //Here you actually writes your test (it() is similar to @Test annotaion of TestNG)
    const urls=["/ui",
    	"/ui/eval",
    	"/ui/tabs",
    	"/ui/transform",
    	"/ui/database",
    	"/ui/file",
    	];
    
    it('visit', function () {
        urls.forEach(u=>{
        	cy.visit(u) 
        	cy.wait(1000)
        	cy.screenshot(u)
        })      
    })

})