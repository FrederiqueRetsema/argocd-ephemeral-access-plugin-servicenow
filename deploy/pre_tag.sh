#!/bin/bash

function replace_servicenow_url() {
    echo "Replace ServiceNow URL..."

    ./replace_servicenow_url.sh https://dev123456.service-now.com
    if test $? -ne 0
    then
        exit 1
    fi
}

function markdown_lint() {
    echo "Markdown lint..."

    markdownlint .
    if test $? -ne 0
    then
        exit 1
    fi
}

function shell_check() {
    echo "Shell check..."

    find . -name "*.sh" -exec shellcheck {} \;
    if test $? -ne 0
    then
        exit 1
    fi
}

function go_lint() {
    echo "Go lint..."

    golangci-lint run
    if test $? -ne 0
    then
        exit 1
    fi
}

function unit_test() {
    echo "Unit tests..."

    go test ./... -v -coverprofile=coverage
    if test $? -ne 0
    then
        exit 1
    fi
}

replace_servicenow_url

cd ..

markdown_lint
shell_check
go_lint
unit_test

cd - || exit
