/**
 * @author andy bunce
 * @description Cypress vue-poc
 */

//This is where your test suite starts

describe('My First Test', function () {

    //This function will execute before each test (i.e it())

    beforeEach(function () {
        cy.log('I run before every test in every spec file!!!!!!')
    })

    //Here you actually writes your test (it() is similar to @Test annotaion of TestNG)

    it('home', function () {

        //Click on type button
        cy.visit('/ui')
        cy.screenshot()

    }),
	
	 it('about', function () {

        //Click on type button
        cy.visit('/ui/about')
        cy.screenshot()

    }),
	
	it('documentation', function () {

        //Click on type button
        cy.visit('/ui/documentation')
        cy.screenshot()

    })

})