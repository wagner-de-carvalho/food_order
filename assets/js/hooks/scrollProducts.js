const ScrollProducts = {
    mounted(){
        const selector = "#" + this.el.id;
        this.observer = new IntersectionObserver(entries => {
            const entry = entries[0];

            if (entry.isIntersecting) {
                this.pushEventTo(selector, "load-more", {})
            }
        })
        this.observer.observe(this.el);
    },
    //updated(){  
    //    const pageNumber = this.el.dataset.pageNumber
    //    console.log("Page number: ", pageNumber)
    //},
    destroyed(){
        this.observer.disconnect();
    }
}

export default ScrollProducts;