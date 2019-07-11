module Bouzuya.HTTP.Method
  ( Method(..)
  , fromString
  ) where

import Prelude

import Data.Foldable as Foldable
import Data.Maybe (Maybe)
import Data.Maybe as Maybe

foreign import indexOf :: String -> Char -> Int
foreign import length :: String -> Int
foreign import toCharArray :: String -> Array Char
foreign import toUpperCase :: String -> String

-- https://tools.ietf.org/html/rfc7231#section-4
-- - GET
-- - HEAD
-- - POST
-- - PUT
-- - DELETE
-- - CONNECT
-- - OPTIONS
-- - TRACE
-- https://tools.ietf.org/html/rfc5789
-- - PATCH

data Method
  = CONNECT
  | DELETE
  | GET
  | HEAD
  | OPTIONS
  | PATCH
  | POST
  | PUT
  | TRACE
  | CUSTOM String

instance eqMethod :: Eq Method where
  eq a b = show a == show b

instance showMethod :: Show Method where
  show CONNECT = "CONNECT"
  show DELETE = "DELETE"
  show GET = "GET"
  show HEAD = "HEAD"
  show OPTIONS = "OPTIONS"
  show PATCH = "PATCH"
  show POST = "POST"
  show PUT = "PUT"
  show TRACE = "TRACE"
  show (CUSTOM s) = s

alphaCharsString :: String
alphaCharsString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

fromString :: String -> Maybe Method
fromString "CONNECT" = Maybe.Just CONNECT
fromString "DELETE" = Maybe.Just DELETE
fromString "GET" = Maybe.Just GET
fromString "HEAD" = Maybe.Just HEAD
fromString "OPTIONS" = Maybe.Just OPTIONS
fromString "PATCH" = Maybe.Just PATCH
fromString "POST" = Maybe.Just POST
fromString "PUT" = Maybe.Just PUT
fromString "TRACE" = Maybe.Just TRACE
fromString s
  | isMethodByConvension s = Maybe.Just (CUSTOM s)
  | otherwise = Maybe.Nothing

isLetter :: String -> Boolean
isLetter s = Foldable.all isLetterChar (toCharArray s)

isLetterChar :: Char -> Boolean
isLetterChar c = (indexOf alphaCharsString c) >= 0

isMethodByConvension :: String -> Boolean
isMethodByConvension s = isLetter s && isUpperCase s && isMethod s

isMethod :: String -> Boolean
isMethod = isToken

isToken :: String -> Boolean
isToken s = s /= "" && Foldable.all isTokenChar (toCharArray s)

isTokenChar :: Char -> Boolean
isTokenChar c = (indexOf tokenCharsString c) >= 0

isUpperCase :: String -> Boolean
isUpperCase s = s == (toUpperCase s)

tokenCharsString :: String
tokenCharsString = "!#$%&'*+-.^_`|~0123456789" <> alphaCharsString
