{-# OPTIONS_GHC -fplugin GHC.TypeLits.KnownNat.Solver #-}
{-# LANGUAGE TypeOperators,FlexibleContexts #-}

module TestPlugins where

import GHC.TypeLits (KnownNat, type (+), natVal)
import Data.Proxy


proxyAdd :: Proxy a -> Proxy b -> Proxy (a+b)
proxyAdd Proxy Proxy = Proxy

proxyVal :: KnownNat a => Proxy a -> Integer
proxyVal = natVal


-- | Use proxyAdd and proxyVal
--
-- Check the type of f
-- >>> :t f
-- f :: (KnownNat a, KnownNat b) => Proxy a -> Proxy b -> Integer
--
-- Check that the plugin works within the doctest session:
-- >>> :set -fplugin GHC.TypeLits.KnownNat.Solver
-- >>> :t \a b -> proxyVal (proxyAdd a b)
-- \a b -> proxyVal (proxyAdd a b)
--   :: (KnownNat a, KnownNat b) => Proxy a -> Proxy b -> Integer
f :: (KnownNat a, KnownNat b) => Proxy a -> Proxy b -> Integer
f = \a b -> proxyVal (proxyAdd a b)
