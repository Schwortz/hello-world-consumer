#!/usr/bin/env python3
"""Example application that uses the hello-world-test-private-repo package."""

from hello_world import say_hello


def main():
    """Main function demonstrating the hello world package."""
    print("=" * 50)
    print("Hello World Consumer Application")
    print("=" * 50)
    print()
    
    # Use the say_hello function from the private package
    greeting1 = say_hello()
    print(f"Default greeting: {greeting1}")
    
    greeting2 = say_hello("Python Developer")
    print(f"Custom greeting: {greeting2}")
    
    greeting3 = say_hello("Private Repository")
    print(f"Another greeting: {greeting3}")
    
    print()
    print("=" * 50)
    print("All greetings completed successfully!")
    print("=" * 50)


if __name__ == "__main__":
    main()

