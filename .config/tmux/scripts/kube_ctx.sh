#!/bin/bash
ctx=$(kubectl config current-context 2>/dev/null)
if [ -n "$ctx" ]; then
  echo "󱃾  $ctx"
fi
