const puppeteer = require('puppeteer');
const fs = require('fs'); // Required to read HTML from a file

async function generatePdfFromHtml() {
	const browser = await puppeteer.launch(); // Launch a new browser instance
	const page = await browser.newPage(); // Open a new page

	// Option 1: Load HTML from a string
	const htmlContent = `
    <html>
      <head>
        <title>Sample PDF</title>
        <style>
          body { font-family: sans-serif; margin: 20px; }
          h1 { color: #333; }
          p { line-height: 1.5; }
        </style>
      </head>
      <body>
        <h1>Hello from Puppeteer!</h1>
        <p>This is a sample PDF generated from HTML content.</p>
        <p>You can include any valid HTML and CSS here.</p>
      </body>
    </html>
  `;
	await page.setContent(htmlContent, { waitUntil: 'networkidle0' }); // Set page content and wait for network to be idle

	// Option 2: Load HTML from a file
	// Uncomment the following lines to use this option and ensure 'template.html' exists
	/*
  const htmlFromFile = fs.readFileSync('./template.html', 'utf8');
  await page.setContent(htmlFromFile, { waitUntil: 'networkidle0' });
  */

	// Generate the PDF
	await page.pdf({
		path: 'output.pdf', // Path to save the PDF file
		format: 'A4', // Paper format (e.g., 'A4', 'Letter')
		printBackground: true, // Include background graphics
		margin: {
			top: '1in',
			right: '1in',
			bottom: '1in',
			left: '1in',
		},
	});

	await browser.close(); // Close the browser instance
	console.log('PDF generated successfully!');
}

generatePdfFromHtml();
