#!/usr/bin/env python3

'''
Focus i3 container by title or title_format (matches using similarity score)

Example:
    i3-focus-title.sh title

If you want to execute "focus child" after focusing the container by the title,
 you can choose how many times "focus child" will be executed by passing
 a number as the second parameter to the script. This is useful if you want to
 find a container by the title, but that container is actually a parent container
 and you want to instead focus a child of that container.
 This won't affect i3 behavior if the container does not have child containers,
 so you can always use the number after the title (I use the value '5' in my i3
 config to be certain that I'll never focus a parent container by accident):

    i3-focus-title.sh "my title" 5

Example in i3 config:
    bindsym $mod+x exec i3-input -F 'exec i3-focus-title.sh "%s"' -P 'Focus title: '

Dependencies:
    - i3-py     (pip install i3-py) (https://github.com/ziberna/i3-py)
    - Python 3  (tested with 3.5.3)

Author: yuriescl@gmail.com
Last Updated: 03 Dec 2017
'''

from difflib import SequenceMatcher as SM
import i3
import sys


def find_title_format(matches, dic, title):
    if "nodes" in dic:
        for node in dic["nodes"]:
            matches = find_title_format(matches, node, title)
    if "title_format" in dic: # check title_format if exists
        dic_title = dic["title_format"]
        matches[dic["id"]] = {
                                "title": dic_title.lower(),
                                "ratio": SM(None, dic_title, title).ratio()  # similarity score (0 - 1) 
                             }
    elif "window_properties" in dic: # check properties title instead
        window_properties = dic["window_properties"]
        if "title" in window_properties: 
            wp_title = window_properties["title"]
            matches[dic["id"]] = {
                                    "title": wp_title.lower(),
                                    "ratio": SM(None, wp_title, title).ratio()  # similarity score (0 - 1)
                                 }

    return matches


def improved_matches(matches, title):
    title = title.lower()
    title_array = title.split(" ")
    new_matches = {}
    for con_id, values in matches.items():
        add = False
        if values["ratio"] > 0:
            for title_substr in title_array:
                if title_substr in values["title"]:
                    add = True
        if add is True:
            new_matches[con_id] = values

    return new_matches

def focus_child(child_level):
    for i in range(0, child_level):
        i3.command('focus child')


if __name__ == "__main__":
    if len(sys.argv) > 1:
        title = sys.argv[1]
        if title is not None and title.strip() != "":
            tree = i3.get_tree()
            matches = find_title_format(dict(), tree, title)
            matches = improved_matches(matches, title)
            if len(matches) > 0:
                highest_match_ratio = 0
                best_con_id = 0
                for con_id, values in matches.items():
                    if values["ratio"] > highest_match_ratio:
                        best_con_id = con_id
                        highest_match_ratio = values["ratio"]
                i3.focus(con_id=best_con_id)
                if len(sys.argv) > 2:
                    child_level = int(sys.argv[2])
                    focus_child(child_level)