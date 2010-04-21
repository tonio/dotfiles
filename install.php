#!/usr/bin/env php
<?php

$excludes = array(
  '.gitignore',
  '.git',
  'install.php'
);

foreach (new DirectoryIterator('./') as $item) {
  if (
    in_array($item, $excludes) || 
    $item->isDot() ||
    preg_match('/\.sw(p|o)$/', $item->getFileName())
  ) continue;
  
  $src = dirname(__FILE__).'/'.$item;
  $dst = '~/'.$item;
  `rm -ri $dst`;
  `ln -s $src $dst`;
}
