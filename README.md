# Flutter Post List Application

This Flutter application fetches and displays a list of posts using the API [https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts). The app also provides a detailed view for each post, marking posts as "Read" and incorporating timers with pause/resume functionality. Data persistence is achieved through local storage.

---

## **Features**

1. **Post Listing:**
    - Fetches a list of posts from the API endpoint `/posts`.
    - Displays post titles in a scrollable list.

2. **Mark as Read:**
    - Clicking on a post marks it as "read" by changing its background color from light yellow to white.

3. **Detailed View:**
    - Opens a new screen displaying the post's description (`body`) when clicked.

4. **Timer with Pause/Resume:**
    - Each list item displays a timer start to 0.
    - The timer pauses when the item is scrolled out of view or when navigating to the detail screen.
    - The timer resumes when the item reappears.

5. **Local Storage:**
    - Caches posts locally using `shared_preferences` for data persistence.
    - Initially loads data from local storage, then synchronizes with the API in the background.

---

## **Packages Used**

| **Package Name**       | **Version** | **Purpose**                                                                           |
|-------------------------|-------------|---------------------------------------------------------------------------------------|
| `http`                 | `^1.0.0`    | For API calls to fetch and interact with the post data.                              |
| `shared_preferences`   | `^2.0.15`   | For local storage and data persistence.                                              |
| `visibility_detector`  | `^0.2.0`    | To detect when list items become visible or invisible for timer functionality.       |
| `provider`             | `^6.0.5`    | For state management, ensuring clean and manageable code.                            |
| `google_fonts`         | `any`       | For enhancing UI with custom fonts.                                                  |

---

## **How It Works**

### **1. Post List**
- Fetch posts from the `/posts` endpoint.
- Display the posts in a `ListView`.
- Assign a random timer (10s, 20s, or 25s) to each post.

### **2. Mark as Read**
- When a post is clicked, change its background color to white using a state variable stored locally.

### **3. Timer Functionality**
- Use `visibility_detector` to detect if an item is visible in the viewport.
- Pause the timer if the item is scrolled out or the detail screen is opened.
- Resume the timer when the item reappears.

### **4. Detailed View**
- Open a new screen using `/posts/{postId}` to fetch the post details.
- Display the description (`body`) of the post.

### **5. Local Storage**
- Check for cached data in `shared_preferences` before making API calls.
- Synchronize the API response in the background to update local data.