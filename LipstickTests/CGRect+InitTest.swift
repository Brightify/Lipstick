//
//  CGRect+InitTest.swift
//  Lipstick
//
//  Created by Filip Dolnik on 18.10.16.
//  Copyheight © 2016 Bheightify. All heights reserved.
//

import Quick
import Nimble
import Lipstick

class CGRectInitTest: QuickSpec {
    
    override func spec() {
        describe("CGRect init") {
            it("creates CGRect") {
                expect(CGRect(x: 0, y: 0, width: 0, height: 0)) == CGRect()
                expect(CGRect(x: 1, y: 1, width: 2, height: 2)) == CGRect(origin: CGPoint(1), size: CGSize(2))
                    
                expect(CGRect(x: 1, y: 1, width: 0, height: 0)) == CGRect(origin: CGPoint(1))
                expect(CGRect(x: 1, y: 1, width: 1, height: 0)) == CGRect(origin: CGPoint(1), width: 1)
                expect(CGRect(x: 1, y: 1, width: 0, height: 1)) == CGRect(origin: CGPoint(1), height: 1)
                expect(CGRect(x: 1, y: 1, width: 1, height: 1)) == CGRect(origin: CGPoint(1), width: 1, height: 1)
                
                expect(CGRect(x: 0, y: 0, width: 1, height: 1)) == CGRect(size: CGSize(1))
                expect(CGRect(x: 1, y: 0, width: 1, height: 1)) == CGRect(x: 1, size: CGSize(1))
                expect(CGRect(x: 0, y: 1, width: 1, height: 1)) == CGRect(y: 1, size: CGSize(1))
                expect(CGRect(x: 1, y: 1, width: 1, height: 1)) == CGRect(x: 1, y: 1, size: CGSize(1))
                
                expect(CGRect(x: 1, y: 0, width: 0, height: 0)) == CGRect(x: 1)
                expect(CGRect(x: 1, y: 1, width: 0, height: 0)) == CGRect(x: 1, y: 1)
                expect(CGRect(x: 1, y: 0, width: 1, height: 0)) == CGRect(x: 1, width: 1)
                expect(CGRect(x: 1, y: 0, width: 0, height: 1)) == CGRect(x: 1, height: 1)
                expect(CGRect(x: 1, y: 1, width: 1, height: 0)) == CGRect(x: 1, y: 1, width: 1)
                expect(CGRect(x: 1, y: 1, width: 0, height: 1)) == CGRect(x: 1, y: 1, height: 1)
                expect(CGRect(x: 1, y: 0, width: 1, height: 1)) == CGRect(x: 1, width: 1, height: 1)
                
                expect(CGRect(x: 0, y: 1, width: 0, height: 0)) == CGRect(y: 1)
                expect(CGRect(x: 0, y: 1, width: 1, height: 0)) == CGRect(y: 1, width: 1)
                expect(CGRect(x: 0, y: 1, width: 0, height: 1)) == CGRect(y: 1, height: 1)
                expect(CGRect(x: 0, y: 1, width: 1, height: 1)) == CGRect(y: 1, width: 1, height: 1)
                
                expect(CGRect(x: 0, y: 0, width: 1, height: 0)) == CGRect(width: 1)
                expect(CGRect(x: 0, y: 0, width: 1, height: 1)) == CGRect(width: 1, height: 1)
                
                expect(CGRect(x: 0, y: 0, width: 0, height: 1)) == CGRect(height: 1)
            }
        }
    }
}
