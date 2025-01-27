# Blog post

**Statistics: How PostgreSQL Counts Without Counting**

* [Part 1: A bird's-eye view into PostgreSQL statistics](https://traderepublic.substack.com/p/statistics-how-postgresql-counts)
* Part 2 coming soon!

# How To

Just run `start.sh`. It starts a PostgreSQL Docker container, and then runs the tutorial on it.

<img align="left" src="./img/exclamation.png" width="50">
<i>If you don't have Docker, you can adapt <code>start.sh</code> to connect to your favorite PostgreSQL server, but this is NOT
RECOMMENDED unless you have a playground instance. This is because the scripts drop and recreate some objects such as
the <code>public</code> schema!</i>

----

The scripts display images using [viu](https://github.com/atanunq/viu). To render the images properly, use a terminal
with native support for graphics protocol (e.g., iTerm2 and Kitty), like this:

![Key Takeaways](./img/key_takeaways.png)
