module Test.Main where

import Bouzuya.HTTP.Method as Method
import Control.Bind (discard)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.AVar (AVAR)
import Control.Monad.Eff.Console (CONSOLE)
import Data.Maybe (Maybe(..))
import Data.Show (show)
import Data.Unit (Unit)
import Prelude (($), (/=), (==))
import Test.Unit (suite, test)
import Test.Unit.Assert as Assert
import Test.Unit.Console (TESTOUTPUT)
import Test.Unit.Main (runTest)

main
  :: forall e
  . Eff
      ( avar :: AVAR
      , console :: CONSOLE
      , testOutput :: TESTOUTPUT
      | e
      )
      Unit
main = runTest do
  suite "Show" do
    test "show" do
      Assert.equal (show Method.CONNECT) "CONNECT"
      Assert.equal (show Method.DELETE) "DELETE"
      Assert.equal (show Method.GET) "GET"
      Assert.equal (show Method.HEAD) "HEAD"
      Assert.equal (show Method.OPTIONS) "OPTIONS"
      Assert.equal (show Method.PATCH) "PATCH"
      Assert.equal (show Method.POST) "POST"
      Assert.equal (show Method.PUT) "PUT"
      Assert.equal (show Method.TRACE) "TRACE"
      Assert.equal (show (Method.CUSTOM "FOO")) "FOO"

  suite "Eq" do
    test "eq" do
      Assert.equal Method.CONNECT Method.CONNECT
      Assert.equal Method.DELETE Method.DELETE
      Assert.equal Method.GET Method.GET
      Assert.equal Method.HEAD Method.HEAD
      Assert.equal Method.OPTIONS Method.OPTIONS
      Assert.equal Method.PATCH Method.PATCH
      Assert.equal Method.POST Method.POST
      Assert.equal Method.PUT Method.PUT
      Assert.equal Method.TRACE Method.TRACE
      Assert.equal (Method.CUSTOM "FOO") (Method.CUSTOM "FOO")

    test "notEq" do
      Assert.assert "notEq " $ Method.CONNECT /= Method.DELETE
      Assert.assert "notEq" $ (Method.CUSTOM "FOO") /= (Method.CUSTOM "BAR")

  suite "fromString" do
    test "not CUSTOM" do
      Assert.equal (Method.fromString "CONNECT") (Just Method.CONNECT)
      Assert.equal (Method.fromString "DELETE") (Just Method.DELETE)
      Assert.equal (Method.fromString "GET") (Just Method.GET)
      Assert.equal (Method.fromString "HEAD") (Just Method.HEAD)
      Assert.equal (Method.fromString "OPTIONS") (Just Method.OPTIONS)
      Assert.equal (Method.fromString "PATCH") (Just Method.PATCH)
      Assert.equal (Method.fromString "POST") (Just Method.POST)
      Assert.equal (Method.fromString "PUT") (Just Method.PUT)
      Assert.equal (Method.fromString "TRACE") (Just Method.TRACE)

    test "CUSTOM" do
      Assert.equal (Method.fromString "FOO") (Just (Method.CUSTOM "FOO"))

    test "Nothing" do
      Assert.assert "is null" $
        (Method.fromString "") == Nothing
      Assert.assert "is not token" $
        (Method.fromString " ") == Nothing
      Assert.assert "is not token" $
        (Method.fromString "\"") == Nothing
      Assert.assert "is token, but is not letter char" $
        (Method.fromString "!") == Nothing
      Assert.assert "is token, but is not upper case" $
        (Method.fromString "foo") == Nothing
