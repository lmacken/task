////////////////////////////////////////////////////////////////////////////////
// taskwarrior - a command line task list manager.
//
// Copyright 2006 - 2011, Paul Beckingham, Federico Hernandez.
// All rights reserved.
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation; either version 2 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, write to the
//
//     Free Software Foundation, Inc.,
//     51 Franklin Street, Fifth Floor,
//     Boston, MA
//     02110-1301
//     USA
//
////////////////////////////////////////////////////////////////////////////////
#ifndef INCLUDED_E9
#define INCLUDED_E9
#define L10N                                           // Localization complete.

#include <string>
#include <stack>
#include <Arguments.h>
#include <Task.h>
#include <RX.h>
#include <Variant.h>

class E9
{
public:
  E9 (Arguments&);
  ~E9 ();
  bool eval (const Task&);
  bool evalFilter (const Task&);
  std::string evalE9 (const Task&);
  void eval (const Task&, std::vector <Variant>&);

private:
  void expand_sequence ();
  void implicit_and ();
  void expand_tag ();
  void expand_pattern ();
  void expand_attr ();
  void expand_attmod ();
  void expand_word ();
  void expand_tokens ();
  void postfix ();

  void tokenize (const std::string&, const std::string&, std::vector <std::string>&, Arguments&);
  void create_variant (Variant&, const std::string&, const std::string&);
  bool is_new_style ();

private:
  bool eval_match (Variant&, Variant&, bool);

private:
  Arguments _args;
  std::map <std::string, RX> _regexes;
  bool _prepared;
};

#endif
////////////////////////////////////////////////////////////////////////////////