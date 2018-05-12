module Bouzuya.HTTP.Method
  ( Method(..)
  , fromString
  ) where

import Data.Boolean (otherwise)
import Data.Eq (class Eq, (/=), (==))
import Data.Foldable (all)
import Data.HeytingAlgebra ((&&))
import Data.Maybe (Maybe(..))
import Data.Ord ((>=))
import Data.Semigroup ((<>))
import Data.Show (class Show, show)

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
fromString "CONNECT" = Just CONNECT
fromString "DELETE" = Just DELETE
fromString "GET" = Just GET
fromString "HEAD" = Just HEAD
fromString "OPTIONS" = Just OPTIONS
fromString "PATCH" = Just PATCH
fromString "POST" = Just POST
fromString "PUT" = Just PUT
fromString "TRACE" = Just TRACE
fromString s
  | isMethodByConvension s = Just (CUSTOM s)
  | otherwise = Nothing

isLetter :: String -> Boolean
isLetter s = all isLetterChar (toCharArray s)

isLetterChar :: Char -> Boolean
isLetterChar c = (indexOf alphaCharsString c) >= 0

isMethodByConvension :: String -> Boolean
isMethodByConvension s = isLetter s && isUpperCase s && isMethod s

isMethod :: String -> Boolean
isMethod = isToken

isToken :: String -> Boolean
isToken s = s /= "" && all isTokenChar (toCharArray s)

isTokenChar :: Char -> Boolean
isTokenChar c = (indexOf tokenCharsString c) >= 0

isUpperCase :: String -> Boolean
isUpperCase s = s == (toUpperCase s)

tokenCharsString :: String
tokenCharsString = "!#$%&'*+-.^_`|~0123456789" <> alphaCharsString
